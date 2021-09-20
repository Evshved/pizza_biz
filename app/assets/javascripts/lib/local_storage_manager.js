function storagePresence() {
  return typeof (Storage) !== 'undefined';
}

function setValueToStorage(storageData, data) {
  if (!storagePresence()) return;
  checkExistingOrder();
  if (storageData === null) {
    localStorage.setItem('pizzaOrder', JSON.stringify(data))
  } else {
    var mergeData = $.extend({}, storageData, data);
    localStorage.setItem('pizzaOrder', JSON.stringify(mergeData))
  }
}

function checkExistingOrder() {
  if (!storagePresence()) return;
  if (localStorage.getItem('pizzaOrder') === null) {
    localStorage.setItem('pizzaOrder', JSON.stringify(''))
  }
}

function getStorage() {
  if (!storagePresence()) return;
  return JSON.parse(localStorage.getItem('pizzaOrder'))
}
