import React, { Component } from 'react';
import './Sidebar.css';

class Sidebar extends Component {
    render() {
        return (
            <div className={"Sidebar"}>
                {this.props.children}
            </div>
        );
    }
}

export default Sidebar;
