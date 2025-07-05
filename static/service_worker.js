'use strict';

self.addEventListener('install', event => {
  console.log('Service Worker installing.');
});

self.addEventListener('activate', event => {
  console.log('Service Worker activating.');
});

self.addEventListener('push', event => {
  console.log('[Service Worker] Push Received.');

  let data = {};
  if (event.data) {
    try {
      data = event.data.json();
    } catch (e) {
      data = { title: 'Notificación', body: event.data.text() };
    }
  }

  const options = {
    body: data.body || 'Sin contenido',
    icon: data.icon || '/static/icon.png',
    badge: data.icon || '/static/icon.png'
  };

  event.waitUntil(
    self.registration.showNotification(data.title || 'UrbanFix', options)
  );
});
