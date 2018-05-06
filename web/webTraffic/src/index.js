import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import registerServiceWorker from './registerServiceWorker';
import {unregister} from './registerServiceWorker';

ReactDOM.render(<App />, document.getElementById('root'));
// registerServiceWorker();

// for production to prevent console log warnings
// "Request scheme 'chrome-extension' is unsupported" by 
// service worker 
unregister();
