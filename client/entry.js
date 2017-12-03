import React from 'react';
import { render } from 'react-dom';
import { createStore, applyMiddleware } from 'redux';
import { Provider } from 'react-redux';
import thunkMiddleware from 'redux-thunk';
import reducer from './reducers';
import App from './components/App';
import { getDefaultState } from './defaultState';

let store = createStore(reducer, getDefaultState(), applyMiddleware(thunkMiddleware));

document.addEventListener('DOMContentLoaded', () => {
  render((
    <Provider store={store}>
      <App />
    </Provider>
  ), document.getElementById('react-root'));
});
