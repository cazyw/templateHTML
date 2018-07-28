console.log('server is running');

function component() {
  var element = document.createElement('div');

  // Lodash, currently included via a script, is required for this line to work
  element.innerHTML = 'Webpack is running';

  return element;
}

document.body.appendChild(component());
