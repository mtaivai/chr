import React, { Component } from 'react';


import {Container, Row, Col, Nav, NavItem, NavLink} from 'reactstrap';

import Sidebar from './Sidebar';

import './DashboardLayout.css';


class DashboardLayout extends Component {
    render() {

        let sidebar = null;
        const mainChildren = [];

        for (let i = 0; i < this.props.children.length; i++) {
            const child = this.props.children[i];
            if (child.type === Sidebar) {
                if (sidebar) {
                    console.error("Only one Sidebar element is allowed");
                } else {
                    sidebar = child;
                }
            } else {
                mainChildren.push(child);
            }
        }

        return (
            <Container className={"DashboardLayout"} fluid={true}>
                <Row>
                    <nav className={"col-md-2 d-none d-md-block bg-light Sidebar"}>
                        <div className={"sidebar-sticky"}>
                            {sidebar.props.children}
                        </div>
                    </nav>
                    <main className={"col-md-9 ml-sm-auto col-lg-10 pt-3 px-4"}>
                        {mainChildren}
                    </main>
                </Row>
            </Container>
        );
    }
}


export default DashboardLayout;
