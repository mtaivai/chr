import React, { Component } from 'react';

// import {RouterNav, NavBar, NavBarCollapse, RouterNavItem} from './components/nav';

// import {
//     Container,
//     Row,
//     Col,
//     Nav as R_Nav,
//     NavItem as R_NavItem,
//     NavLink as R_NavLink,
//     Button,
//     Form,
//     FormGroup,
//     Label,
//     Input,
//     FormText} from 'reactstrap';

// import { Router, Route } from 'react-router'
// import {connect} from 'react-redux'

import AppHeader from './AppHeader';
// import DashboardLayout from './DashboardLayout';
// import Sidebar from './Sidebar';
// import PersonalInfoForm from './PersonalInfoForm';
// import ContactInfoForm from './ContactInfoForm';
// import PersonPage from './components/PersonPage';
import PersonList from './components/PersonList';

import './App.css';
import PeoplePage from "./components/PeoplePage";

class App extends Component {
    render() {
        return (
            <div className="App">
                <AppHeader/>

                <PeoplePage/>

      </div>
    );
  }
}
// const mapStateToProps = (state) => {
//     return {/*routerLocation: state.router.location*/};
// };
// // export default connect(mapStateToProps)(App);
export default App;
