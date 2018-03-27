import React from 'react'
import PropTypes from 'prop-types'
import {Link, Route} from 'react-router-dom'


/*
 * This is customized from
 * https://github.com/ReactTraining/react-router/blob/master/packages/react-router-dom/modules/NavLink.js
 * to create Bootstrap 4 navigation links wrapped in 'li' elements.
 *
 */

/**
 * A <Link> wrapper that knows if it's "active" or not.
 * @author Mikko Taivainen
 */

class RouterNavItem extends React.Component {

    // constructor(props) {
    //     super(props);
    // }


    render() {
        const {
            to,
            exact,
            strict,
            location,
            activeClassName,
            activeLinkClassName,
            className,
            linkClassName,
            activeStyle,
            activeLinkStyle,
            style,
            linkStyle,
            disabled,
            disabledClassName,
            disabledLinkClassName,
            disabledStyle,
            disabledLinkStyle,
            isActive: getIsActive,
            'aria-current': ariaCurrent,
            onClick,
            ...rest} = this.props;

        //const actualLocation = this.state.location || location;
        const path = (!to) ? '' : (typeof to === 'object' ? to.pathname : to);


        // console.log("Render: " + to);

        // Regex taken from: https://github.com/pillarjs/path-to-regexp/blob/master/index.js#L202
        const escapedPath = path ? path.replace(/([.+*?=^!:${}()[\]|/\\])/g, '\\$1') : "";

        return (
            <Route
                path={escapedPath}
                exact={exact}
                strict={strict}
                location={location}
                children={({location, match}) => {

                    const isActive = !!(getIsActive ? getIsActive(match, location) : match);

                    const isDisabled = !!(typeof(disabled) === 'function' ? disabled(match, location) : disabled);

                    const actualClassName = [className, isDisabled ? disabledClassName : '' , isActive ? activeClassName : ''].filter(i => i).join(' ');
                    const actualLinkClassName = [linkClassName, isDisabled ? disabledLinkClassName : '' , isActive ? activeLinkClassName : ''].filter(i => i).join(' ');

                    const actualStyle = isDisabled ? disabledStyle : (isActive ? activeStyle : style);
                    const actualLinkStyle = isDisabled ? disabledLinkStyle : (isActive ? activeLinkStyle : linkStyle);

                    return (
                        <li className={actualClassName} style={actualStyle}>
                            <Link
                                to={to ? to : ''}
                                onClick={(e) => {if (typeof onClick === 'function') onClick(e); if (isDisabled) e.preventDefault()}}
                                className={actualLinkClassName}
                                style={actualLinkStyle}
                                aria-current={isActive ? ariaCurrent : null}
                                {...rest}
                            />
                        </li>
                    );


                }}
            />
        )
    };
}

RouterNavItem.propTypes = {
    to: Link.propTypes.to,
    exact: PropTypes.bool,
    strict: PropTypes.bool,
    location: PropTypes.object,
    activeClassName: PropTypes.string,
    activeLinkClassName: PropTypes.string,
    className: PropTypes.string,
    linkClassName: PropTypes.string,
    activeStyle: PropTypes.object,
    activeLinkStyle: PropTypes.object,
    style: PropTypes.object,
    linkStyle: PropTypes.object,
    isActive: PropTypes.func,
    disabled: PropTypes.bool,
    disabledClassName: PropTypes.string,
    disabledLinkClassName: PropTypes.string,
    'aria-current': PropTypes.oneOf(['page', 'step', 'location', 'date', 'time', 'true'])
};

RouterNavItem.defaultProps = {
    className: 'nav-item',
    linkClassName: 'nav-link',
    activeClassName: 'active',
    activeLinkClassName: 'active',
    'aria-current': 'true',
    disabledClassName: 'disabled',
    disabledLinkClassName: 'disabled'
};

//
// const ConnectedNavLink = connect(
//     (state) => ({location: state.router.location})
// )(NavLink);
//

export default RouterNavItem;