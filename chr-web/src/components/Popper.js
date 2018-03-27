import React, { Component } from 'react';

import './TagInput.css';
import PropTypes from "prop-types";
import enhanceWithClickOutside from "react-click-outside";
import PopperJS from 'popper.js';

class Popper extends Component {

    constructor(props) {
        super(props);
        this.state = {
        };
    }

    componentWillMount() {

        // React.Children.forEach(this.props.children, (child) => {
        //     if (child.type === 'option') {
        //     }
        // }, null);


    }


    componentDidMount() {
        const ref = (typeof this.props.reference === 'function')
            ? this.props.reference()
            : this.props.reference;

        this.popperObj = new PopperJS(
            ref,
            this.wrapper,
            {
                placement: this.props.placement
            }
        );
    }

    componentDidUpdate(prevProps, prevState, prevContext) {
    }

    componentWillUnmount() {
        this.popperObj.destroy();
        this.popperObj = null;
    }


    render() {

        let {reference, placement, style, ...rest} = this.props;

        const wrapperStyle = {
            position: "absolute",
            zIndex: "1000",
            ...style
        };


        return (
            <div style={wrapperStyle} ref={(e) => this.wrapper = e} {...rest}>
                {this.props.children}
            </div>
        );
    }

}

Popper.propTypes = {
    reference: PropTypes.oneOfType([
        PropTypes.func,
        PropTypes.object]).isRequired,
    placement: PropTypes.oneOf([
        'auto-start',
        'auto',
        'auto-end',
        'top-start',
        'top',
        'top-end',
        'right-start',
        'right',
        'right-end',
        'bottom-end',
        'bottom',
        'bottom-start',
        'left-end',
        'left',
        'left-start'])


};

Popper.defaultProps = {
    placement: 'bottom'

};

Popper.contextTypes = {

};


export default enhanceWithClickOutside(Popper);
