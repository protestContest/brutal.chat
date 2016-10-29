import React from 'react';
import { render } from 'react-dom';
import { createStore, applyMiddleware } from 'redux';
import { Provider } from 'react-redux';
import thunkMiddleware from 'redux-thunk';
import reducer from './reducers';
import sockets from './sockets';
import App from './components/App';

let store = createStore(reducer, applyMiddleware(thunkMiddleware));
sockets.init();

document.addEventListener('DOMContentLoaded', () => {
  render((
    <Provider store={store}>
      <App />
    </Provider>
  ), document.getElementById('react-root'));
});
