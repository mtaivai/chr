import React, { Component } from 'react';

import './CV.css';


class CV extends Component {
    render() {
        return (
            <article className="CV container">

                <h1 className="person-name">John Doe</h1>

                <section className={"address"}>
                    <address>
                        <span className="address-line address-street">123 Doe Way</span>
                        <span className="address-line address-town">Smallville</span>
                        <span className="address-line address-country">Somewhere</span>
                    </address>
                </section>

                <section>
                    <h2>Koulutus</h2>


                    <div className="bio-list graduation">
                        <div className="bio-line">
                            <div className="bio-line-date">
                                <span className="from-date">08/<span className="year">1999</span></span>
                                -
                                <span className="to-date">06/<span className="year">2015</span></span>
                            </div>
                            <div className="bio-line-details">
                                <span className={"bio-line-details-title graduation-school"}>University of Eastern Finland</span>
                                <span className={"bio-line-details-subtitle graduation-title"}>MsC, Computer Science</span>
                                <span className={"bio-line-details-body graduation-details"}>Minor: Economics</span>
                            </div>
                        </div>
                    </div>


                </section>

                <section>
                    <h2>Työkokemus</h2>

                    <div className="bio-list job-position">
                        <div className="bio-line">
                            <div className="bio-line-date">
                                <span className="from-date">08/<span className="year">1999</span></span>
                                -
                                <span className="to-date">06/<span className="year">2015</span></span>
                            </div>
                            <div className="bio-line-details">
                                <span className={"bio-line-details-title job-position-organization"}>ACME Inc.</span>
                                <span className={"bio-line-details-subtitle job-position-title"}>Head of Arts</span>
                                <span className={"bio-line-details-body job-position-details"}>Drawing cartoons etc.</span>
                            </div>
                        </div>
                    </div>

                </section>
            </article>
        )
    }
}

export default CV;
