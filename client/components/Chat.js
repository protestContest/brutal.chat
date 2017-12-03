import React from 'react';
import { connect } from 'react-redux';
import { sendKey, endMessage, invalidateInput } from '../actions';
import MessageBox from './MessageBox';
import EventBox from './EventBox';

class Chat extends React.PureComponent {
  constructor(props) {
    super(props);
    this.state = { timeout: null };
    this.onKeyUp = this.onKeyUp.bind(this);
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

  onKeyUp(event) {
    if (event.key === 'Enter') {
      this.props.endMessage();
    }

    if (event.key === 'Backspace') {
      this.props.onKey('Backspace');
    }

    this.refs.container.scrollTop = this.refs.container.scrollHeight;
    if (event.ctrlKey || event.altKey || event.metaKey) return;

    clearTimeout(this.state.timeout);

    if (event.key.length === 1) {
      this.props.onKey(event.key);
    }

    this.setState({ timeout: setTimeout(this.props.invalidateInput, 3000) });
  }

  render() {
    const borderColor = (this.props.appState === 'recording') ? 'red' : 'black';
    const styles = {
      container: {
        display: 'flex',
        flexDirection: 'column',
        border: '4px solid ' + borderColor,
        padding: '2vh 2vw',
        alignItems: 'flex-end',
        overflowY: 'hidden',
        flex: '1'
      },
      input: {
        position: 'relative',
        alignSelf: 'flex-start',
        left: '-1000px'
      },
      room: {
        position: 'absolute',
        top: '4px',
        left: '4px',
        background: borderColor,
        color: 'white',
        fontFamily: 'monospace',
        padding: '0 6px 2px 4px'
      }
    };

    const items = this.props.items.map(item => {
      if (item.type === 'event') {
        return <EventBox key={`key-${item.id}`} event={item.id} />;
      } else {
        return <MessageBox key={`message-${item.id}`} message={item.id} />;
      }
    });

    const roomTitle = (this.props.room && this.props.room !== 'default')
      ? <div style={styles.room}>{this.props.room}</div>
      : null;

    return (
      <div ref='container' style={styles.container} onClick={this.focus}>
        {roomTitle}
        {items}
        <input autoFocus={true} autoComplete='off' autoCorrect='off' autoCapitalize='off' ref='input' onKeyUp={this.onKeyUp} style={styles.input} />
      </div>
    );
  }
}

function compareMessages(a, b) {
  return a.timestamp - b.timestamp;
}

const mapStateToProps = (state) => ({
  room: state.room,
  items: [
    ...state.messages.map(message => ({...message, type: 'message'})),
    ...state.events.map(event => ({...event, type: 'event'})),
  ].sort(compareMessages),
  appState: state.appState
});

const mapDispatchToProps = (dispatch) => ({
  onKey: (key) => dispatch(sendKey(key)),
  endMessage: () => dispatch(endMessage()),
  invalidateInput: () => dispatch(invalidateInput())
});

export default connect(mapStateToProps, mapDispatchToProps)(Chat);
