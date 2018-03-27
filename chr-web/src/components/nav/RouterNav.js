import React from 'react'
import PropTypes from 'prop-types'
// import {matchPath} from 'react-router'

/**
 * A navigation menu that connects to an active Router instance and subscribes navigation
 * events - active status of NavLink children is automatically updated.
 *
 * <RouterNav>
 *     <RouterNavItem to={"/somewhere"}/>
 *     ...
 *     <RouterNavItem to={"/elsewhere"}/>
 * </RouterNav>
 *
 * @author Mikko Taivainen
 */
class RouterNav extends React.Component {
    static contextTypes = {
        router: PropTypes.shape({
            history: PropTypes.shape({
                push: PropTypes.func.isRequired,
                replace: PropTypes.func.isRequired,
                createHref: PropTypes.func.isRequired,
                listen: PropTypes.func.isRequired
            }).isRequired,
            route: PropTypes.shape({
                location: PropTypes.object
            })
        }).isRequired
    };
    // constructor(props) {
    //     super(props);
    //
    // }
    componentDidMount() {
        this.unlistenHistory = this.context.router.history.listen(location => {
            this.forceUpdate();

        });
    }
    componentWillUnmount() {

        if (typeof this.unlistenHistory === 'function') {
            this.unlistenHistory();
            this.unlistenHistory = undefined;
        }
    }

    render() {
        const {className, style, children, ...rest} = this.props;

        const childItems = [];
        if (children) {
            React.Children.forEach(children, (child, i) => {
                childItems.push(child);
                // let location = this.context.router.history.location;
                // location = typeof(location) === 'object' ? location.pathname : location;
                //
                // const match = matchPath(location, {
                //     path: child.props.to,
                //     strict: child.props.strict,
                //     exact: child.props.exact
                // });
                // // console.log("match " + child.props.to + ": " + JSON.stringify(match));
                // const isActive = !!match;
                //
                // const li = (<li key={i} className={"nav-item" + (isActive ? ' active' : '')}>{child}</li>);
                // childItems.push(li);

            }, this);
        }

        return (
            <ul className={"nav " + className} style={style} children={childItems} {...rest}/>
        );

    }
}

RouterNav.propTypes = {
    className: PropTypes.string,
    style: PropTypes.object,
};

RouterNav.defaultProps = {
    className: 'navbar-nav mr-auto'
};

export default RouterNav;