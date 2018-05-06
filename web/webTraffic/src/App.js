/*global chrome*/
import React, { Component } from 'react';
import './App.css';
import TrafficContainer from "./TrafficContainer";
import trafficSpy from './img/searching_64.png';
import { getCurrentTab } from "./GetTab";

class App extends Component {
    constructor(props) {
      super(props);
      this.state = {
          traffic: {}
      };

      this.clearData = this.clearData.bind(this);

    }

    clearData() {
      this.setState({
        traffic: {}
      });

      getCurrentTab((tab) => {
        chrome.runtime.sendMessage({ type: 'clear' }, (response) => {
          console.log("storage cleared");
        });

      });
    }

    componentDidMount() {

      getCurrentTab((tab) => {
        chrome.runtime.sendMessage({ type: 'webTraffic' }, (response) => {
          if (response.hasOwnProperty("requests")) {
            this.setState({
                traffic: response
            });
          }
        });

        chrome.runtime.onMessage.addListener((msg, sender, response) => {    
          console.log("MSG ", msg);
          if (msg.hasOwnProperty("requests")) {
            this.setState({
                traffic: msg
            });
          }
        });
      });
    }

    render() {
      console.log("rendering");

      return (
        <div className="App">
          <header className="App-header">
            <div><img src={trafficSpy} alt="spyMaster" /></div>
            <h1 className="App-title">Welcome to WebTraffic</h1>
            <button onClick={this.clearData}>Clear Tab</button>
          </header>
          <p className="App-intro">
              <TrafficContainer traffic={this.state.traffic}/>
          </p>
        </div>
      );
    }
}

export default App;