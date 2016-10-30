import React from 'react';
import { connect } from 'react-redux';
import { sendKey, newMessage } from '../actions';
import MessageBox from './MessageBox';
import EventBox from './EventBox';

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

    const items = this.props.items.map(item => {
      if (item.type === 'event') {
        return <EventBox key={`key-${item.id}`} event={item.id} />;
      } else {
        return <MessageBox key={`message-${item.id}`} message={item.id} />;
      }
    });

    return (
      <div ref='container' style={style} onKeyUp={this.onKeyPress} tabIndex='0'>
        {items}
      </div>
    );
  }
}

function compareMessages(a, b) {
  return a.timestamp - b.timestamp;
}

const mapStateToProps = (state) => ({
  items: [
    ...state.messages.map(message => ({...message, type: 'message'})),
    ...state.events.map(event => ({...event, type: 'event'})),
  ].sort(compareMessages)
});

const mapDispatchToProps = (dispatch) => ({
  onKey: (key) => dispatch(sendKey(key)),
  newMessage: () => dispatch(newMessage())
});

export default connect(mapStateToProps, mapDispatchToProps)(App);