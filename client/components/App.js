import React from 'react';
import { connect } from 'react-redux';
import { sendKey, newMessage } from '../actions';
import MessageBox from './MessageBox';

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

    this.refs.container.scrollTop = this.refs.container.scrollHeight;
  }

  render() {
    const style = {
      display: 'flex',
      flexDirection: 'column',
      border: '4px solid black',
      width: '100vw',
      height: '100vh',
      padding: '2vh 2vw',
      alignItems: 'flex-end',
      overflowY: 'auto'
    };

    const messages = this.props.messages.map(message => (
      <MessageBox key={`message-${message.id}`} message={message.id} />
    ));

    return (
      <div ref='container' style={style} onKeyUp={this.onKeyPress} tabIndex='0'>
        {messages}
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  messages: state.messages
});

const mapDispatchToProps = (dispatch) => ({
  onKey: (key) => dispatch(sendKey(key)),
  newMessage: () => dispatch(newMessage())
});

export default connect(mapStateToProps, mapDispatchToProps)(App);