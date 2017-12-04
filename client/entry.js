import React from 'react';
import { render } from 'react-dom';
import { createStore, applyMiddleware } from 'redux';
import { Provider } from 'react-redux';
import thunkMiddleware from 'redux-thunk';
import reducer from './reducers';
import App from './components/App';
import { getDefaultState } from './defaultState';
import { enter } from './actions';


document.addEventListener('DOMContentLoaded', () => {
  const room = document.querySelector('meta[name="room"]').attributes.content.value;
  const store = createStore(reducer, getDefaultState(room), applyMiddleware(thunkMiddleware));
  if (room !== 'default') {
    store.dispatch(enter());
  }
  render((
    <Provider store={store}>
      <App />
    </Provider>
  ), document.getElementById('react-root'));
});
