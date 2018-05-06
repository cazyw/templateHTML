(function() {
  let storage = {
    requests: {}
  };
  const networkFilters = {
      urls: [
          "*://*/*",
      ],
      types: ["main_frame", "image"]
  };

  chrome.runtime.onMessage.addListener((msg, sender, response) => {    
    switch (msg.type) {
      case 'clear':
        storage = {
          requests: {}
        };
        console.log('clearing storage');
      case 'webTraffic':
        response(storage);
        break;
      default:
        break;
  }

  });

  chrome.webRequest.onSendHeaders.addListener((details) => {
    console.log(details.url);

    let storageSize = Object.keys(storage.requests).length;
    if(storageSize > 1000) {
      storage = {
        requests: {}
      };
      storageSize = 0;
      console.log('maximum reached, storage cleared');
    }

    storage.requests[storageSize] = {
      url: details.url,
      provider: 'random'
    }

    chrome.runtime.sendMessage(storage);
    console.log("Request identified: ", storage);

  }, networkFilters);


  console.log("running in background");
  console.log("storage: ", storage);

}());
