// Flutter Web Bootstrap Script
(function() {
  'use strict';

  // Configuration
  const config = {
    serviceWorkerVersion: null,
    timeoutMillis: 4000,
  };

  // Create flutter loader
  window._flutter = window._flutter || {};
  window._flutter.loader = {
    load: function(options) {
      return new Promise(function(resolve, reject) {
        const settings = Object.assign({
          serviceWorker: {
            serviceWorkerVersion: config.serviceWorkerVersion,
          },
          onEntrypointLoaded: function(engineInitializer) {
            engineInitializer.initializeEngine().then(function(appRunner) {
              appRunner.runApp();
            });
          }
        }, options);

        // Load main.dart.js
        loadMainDartJs(settings).then(resolve).catch(reject);
      });
    }
  };

  function loadMainDartJs(settings) {
    return new Promise(function(resolve, reject) {
      let scriptLoaded = false;

      function loadScript() {
        if (scriptLoaded) return;
        scriptLoaded = true;

        const scriptTag = document.createElement('script');
        scriptTag.src = 'main.dart.js';
        scriptTag.type = 'application/javascript';
        scriptTag.onload = function() {
          if (settings.onEntrypointLoaded) {
            // Create a mock engine initializer
            const engineInitializer = {
              initializeEngine: function() {
                return Promise.resolve({
                  runApp: function() {
                    console.log('Flutter app started');
                    resolve();
                  }
                });
              }
            };
            settings.onEntrypointLoaded(engineInitializer);
          } else {
            resolve();
          }
        };
        scriptTag.onerror = function() {
          reject(new Error('Failed to load main.dart.js'));
        };
        document.body.appendChild(scriptTag);
      }

      // Try to use service worker if available
      if ('serviceWorker' in navigator && settings.serviceWorker) {
        const serviceWorkerUrl = 'flutter_service_worker.js?v=' + (settings.serviceWorker.serviceWorkerVersion || '');

        navigator.serviceWorker.register(serviceWorkerUrl)
          .then(function(reg) {
            function waitForActivation(serviceWorker) {
              serviceWorker.addEventListener('statechange', function() {
                if (serviceWorker.state === 'activated') {
                  console.log('Service worker activated');
                  loadScript();
                }
              });
            }

            if (!reg.active && (reg.installing || reg.waiting)) {
              waitForActivation(reg.installing || reg.waiting);
            } else if (!reg.active || !reg.active.scriptURL.endsWith(settings.serviceWorker.serviceWorkerVersion || '')) {
              console.log('Updating service worker');
              reg.update();
              if (reg.installing) {
                waitForActivation(reg.installing);
              } else {
                loadScript();
              }
            } else {
              console.log('Service worker ready');
              loadScript();
            }
          })
          .catch(function(error) {
            console.warn('Service worker registration failed:', error);
            loadScript();
          });

        // Fallback timeout
        setTimeout(function() {
          if (!scriptLoaded) {
            console.warn('Service worker timeout, loading script directly');
            loadScript();
          }
        }, config.timeoutMillis);
      } else {
        // No service worker support
        loadScript();
      }
    });
  }
})();