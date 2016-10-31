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
    this.refs.container.scrollTop = this.refs.container.scrollHeight;
  }

  focus() {
    this.refs.input.focus();
    this.refs.input.click();
  }

  onKeyPress(event) {
    this.refs.container.scrollTop = this.refs.container.scrollHeight;
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
    const styles = {
      container: {
        display: 'flex',
        flexDirection: 'column',
        border: '4px solid black',
        padding: '2vh 2vw',
        alignItems: 'flex-end',
        overflowY: 'hidden',
        flex: '1'
      },
      input: {
        position: 'relative',
        left: '-1000px'
      }
    };

    const items = this.props.items.map(item => {
      if (item.type === 'event') {
        return <EventBox key={`key-${item.id}`} event={item.id} />;
      } else {
        return <MessageBox key={`message-${item.id}`} message={item.id} />;
      }
    });

    return (
      <div ref='container' style={styles.container} onClick={this.focus}>
        {items}
        <input autoFocus={true} autoComplete='off' autoCorrect='off' autoCapitalize='off' ref='input' onKeyDown={this.onKeyDown} onKeyPress={this.onKeyPress} style={styles.input} />
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