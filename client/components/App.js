import React from 'react';
import { connect } from 'react-redux';
import Chat from './Chat';
import Welcome from './Welcome';

class App extends React.Component {
  render() {
    if (this.props.welcome) {
      return <Welcome />;
    } else {
      return <Chat />
    }
  }
}

const mapStateToProps = (state) => ({
  welcome: state.welcome
});

export default connect(mapStateToProps)(App);
