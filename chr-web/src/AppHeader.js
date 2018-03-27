import React, { Component } from 'react';
import AppNavbar from './AppNavbar';

//import logo from './logo.svg';
import './AppHeader.css';


class AppHeader extends Component {
    render() {
        return (
            <header className={"AppHeader"}>
                {/*<img src={logo} className="App-logo" alt="logo" />*/}
                <AppNavbar/>
            </header>
        )
    }
}

export default AppHeader;
