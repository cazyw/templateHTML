import React, { Component } from 'react';
import pageIcon from './img/page_32.png';
import clickIcon from './img/mouse_32.png';
import videoIcon from './img/video-player_32.png';

export default class TrafficContainer extends Component {
    constructor(props) {
        super(props);
        this.chooseIcon = this.chooseIcon.bind(this);
    }

    chooseIcon(url){
      if(url.includes("events=event2")){
        return (<li><span className="icons"><img src={clickIcon} alt="icon" /></span><span>{`${url}`}</span></li>);
      }
      
      return (<li><span className="icons"><img src={pageIcon} alt="icon" /></span><span>{`${url}`}</span></li>);
    }


    static renderNetworkTrafficData(requests) {
      
        if (requests) {
            return Object.keys(requests).map((key) => {
                const { url } = requests[key];
                let icon = pageIcon;
                if(url.includes("video_id")){
                    icon = videoIcon;
                } else if(url.includes("events=event2")){
                    icon = clickIcon;
                }
                return (<li><span className="icons"><img src={icon} alt="icon" /></span><span className="url">{`${url}`}</span></li>);
            });
        }
        return '';
    }

    render() {
        return (
            <ul>
           {TrafficContainer.renderNetworkTrafficData(this.props.traffic.requests)}
            </ul>
        );
    }
}