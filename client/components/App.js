import React from 'react';
import { connect } from 'react-redux';
import { sendKey, newMessage, invalidateInput } from '../actions';
import MessageBox from './MessageBox';
import EventBox from './EventBox';

class App extends React.PureComponent {
  constructor(props) {
    super(props);
    this.state = { timeout: null };
    this.onKeyPress = this.onKeyPress.bind(this);
    this.onKeyDown = this.onKeyDown.bind(this);
    this.focus = this.focus.bind(this);
  }

  componentDidMount() {
    this.focus();
  }

  componentWillReceiveProps() {
    setTimeout(() => {
      this.refs.container.scrollTop = this.refs.container.scrollHeight;
    }, 100);
  }

  focus() {
    this.refs.input.focus();
    this.refs.input.click();
  }

  onKeyPress(event) {
    if (event.ctrlKey || event.altKey || event.metaKey) return;

    clearTimeout(this.state.timeout);

    if (event.key.length === 1) {
      this.props.onKey(event.key);
    }

    this.setState({ timeout: setTimeout(this.props.invalidateInput, 3000) });
  }

  onKeyDown(event) {
    if (event.key === 'Enter') {
      this.props.newMessage();
    }

    if (event.key === 'Backspace') {
      this.props.onKey('Backspace');
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
      alignItems: 'flex-end',
      overflowY: 'hidden'
    };

    const items = this.props.items.map(item => {
      if (item.type === 'event') {
        return <EventBox key={`key-${item.id}`} event={item.id} />;
      } else {
        return <MessageBox key={`message-${item.id}`} message={item.id} />;
      }
    });

    return (
      <div ref='container' style={style} onClick={this.focus}>
        {items}
        <input autoFocus={true} autoComplete='off' autoCorrect='off' ref='input' onKeyDown={this.onKeyDown} onKeyPress={this.onKeyPress} style={{position: 'absolute', top: '-1000px', left: '-1000px'}} />
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
  newMessage: () => dispatch(newMessage()),
  invalidateInput: () => dispatch(invalidateInput())
});

export default connect(mapStateToProps, mapDispatchToProps)(App);