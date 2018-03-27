import React from 'react'
import { render } from 'react-dom'

import { createStore, compose } from 'redux'

import thunkMiddleware from 'redux-thunk'
import { applyMiddleware } from 'redux'
import statefulPromiseMiddleware from './stateful-promise-middleware'

import { persistState } from 'redux-devtools'

import { Provider } from 'react-redux'

import createHistory from 'history/createBrowserHistory'

import {
    ConnectedRouter,
    // routerReducer,
    // push,
    routerMiddleware
} from 'react-router-redux'

import appReducer from './reducers'
import App from './App'
//import ReactDOM from "react-dom";
//import DevTools from './containers/DevTools'

import 'bootstrap/dist/css/bootstrap.css';
import './index.css';

// Create a history of your choosing (we're using a browser history in this case)
const history = createHistory();


const middleware = applyMiddleware(
    routerMiddleware(history),
    thunkMiddleware,
    statefulPromiseMiddleware
);

function getSessionKey () {
    const matches = window.location.href.match(/[?&]debug=([^&#]+)\b/)
    return (matches && matches.length > 0)
        ? matches[1]
        : null
}

const enhancer = compose(
    middleware,
   // DevTools.instrument(),
    persistState(getSessionKey()));

let store = createStore(
    appReducer,
    window["__REDUX_DEVTOOLS_EXTENSION__"] && window["__REDUX_DEVTOOLS_EXTENSION__"](),
    enhancer);




render(
    <Provider store={store}>
        <ConnectedRouter history={history}>
            <App />
        </ConnectedRouter>
    </Provider>,
    document.getElementById('root')
);
