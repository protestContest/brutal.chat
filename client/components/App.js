import React from 'react';
import { connect } from 'react-redux';
import { sendKey, newMessage } from '../actions';
import MessageBox from './MessageBox';
import InputBox from './InputBox';

class App extends React.PureComponent {
  constructor(props) {
    super(props);
    this.onKeyPress = this.onKeyPress.bind(this);
  }

  componentDidMount() {
    this.refs.container.focus();
  }

  onKeyPress(event) {
    if (event.key === 'Enter') {
      this.props.newMessage();
    }

    if (event.key === 'Backspace') {
      this.props.onKey('Backspace');
    }

    if (event.key.length === 1) {
      this.props.onKey(event.key);
    }
  }

  render() {
    const style = {
      display: 'flex',
      flexDirection: 'column',
      border: '4px solid black',
      width: '100vw',
      height: '100vh',
      padding: '2vh 2vw',
      alignItems: 'flex-end'
    };

    return (
      <div ref='container' style={style} onKeyUp={this.onKeyPress} tabIndex='0'>
        <MessageBox>Hello.</MessageBox>
        <InputBox />
      </div>
    );
  }
}

const mapDispatchToProps = (dispatch) => ({
  onKey: (key) => dispatch(sendKey(key)),
  newMessage: () => dispatch(newMessage())
});

export default connect(null, mapDispatchToProps)(App);