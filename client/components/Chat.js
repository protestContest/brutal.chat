import React from 'react';
import { connect } from 'react-redux';
import { sendKey, endMessage, invalidateInput } from '../actions';
import MessageBox from './MessageBox';
import EventBox from './EventBox';

export const MESSAGE_TIMEOUT = 3000;

class Chat extends React.PureComponent {
  constructor(props) {
    super(props);
    this.state = { timeout: null, showUsers: false };
    this.onKey = this.onKey.bind(this);
    this.focus = this.focus.bind(this);
    this.showUsers = this.showUsers.bind(this);
    this.hideUsers = this.hideUsers.bind(this);
  }

  componentDidMount() {
    this.focus();
  }

  componentWillReceiveProps() {
    setTimeout(() => {
      this.refs.container.scrollTop = this.refs.container.scrollHeight;
    }, 50);
  }

  showUsers() {
    this.setState({ showUsers: true });
  }

  hideUsers() {
    this.setState({ showUsers: false });
  }

  focus() {
    this.refs.input.focus();
    this.refs.input.click();
  }

  onKey(event) {
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

    this.setState({
      timeout: setTimeout(this.props.invalidateInput, MESSAGE_TIMEOUT),
      timeoutEnd: Date.now() + MESSAGE_TIMEOUT
    });
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
        padding: '0 6px 2px 4px',
        zIndex: 1
      },
      userCount: {
        position: 'absolute',
        top: '4px',
        right: '4px',
        background: borderColor,
        color: 'white',
        fontFamily: 'monospace',
        padding: '0 6px 0px 4px'
      },
      userList: {
        display: (this.state.showUsers) ? 'block' : 'none',
        position: 'absolute',
        top: '17px',
        right: '4px',
        background: borderColor,
        color: 'white',
        fontFamily: 'monospace',
        padding: '0 6px 0px 4px'
      },
      userName: {
        textAlign: 'right'
      }
    };

    const items = this.props.items.map(item => {
      if (item.type === 'event') {
        return <EventBox key={`key-${item.id}`} event={item.id} />;
      } else {
        return <MessageBox key={`message-${item.id}`} message={item.id} timeout={this.state.timeoutEnd} />;
      }
    });

    const roomTitle = (this.props.room && this.props.room !== 'default')
      ? <div style={styles.room}>{this.props.room}</div>
      : null;

    const numUsers = (this.props.numUsers < 2)
      ? 'No one here'
      : `${this.props.numUsers} here`;

    const userNames = this.props.users.map(user => <div style={styles.userName} key={`user-${user}`}>{user}</div>);

    return (
      <div ref='container' style={styles.container} onClick={this.focus}>
        {roomTitle}
        {items}
        <div style={styles.userCount} onMouseEnter={this.showUsers} onMouseOut={this.hideUsers}>{numUsers}</div>
        <div style={styles.userList}>{userNames}</div>
        <input autoFocus={true} autoComplete='off' autoCorrect='off' autoCapitalize='off' ref='input' onKeyDown={this.onKey} style={styles.input} />
      </div>
    );
  }
}

function compareMessages(a, b) {
  return a.timestamp - b.timestamp;
}

const mapStateToProps = (state) => ({
  room: state.room,
  numUsers: state.numUsers,
  users: state.users,
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
