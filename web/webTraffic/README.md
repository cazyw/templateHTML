# Chrome Extension

Chrome extension that captures web traffic

## Installing and running the App

1. Run `npm install`
2. Run `npm run build`. This will create a build folder
3. Load the extension in Chrome pointing to this build folder
4. background.js in `/public` holds the javascript running in the background
5. `/src` folder holds the React front-end

## Features

This app:
* captures http/https requests sent in the browser (non-tab specific, captures all traffic)
* displays the requests in real time in a pop-up

## Background.js

This captures all web traffic and stores in an object that is sent to the front end

## App.js

This is the overall front-end that listens for any messages sent to it and then renders to the pop-up
