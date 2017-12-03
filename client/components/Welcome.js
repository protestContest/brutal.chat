import React from 'react';
import { connect } from 'react-redux';
import { enter } from '../actions';

class Welcome extends React.Component {
  render() {
    const styles = {
      container: {
        display: 'flex',
        flexDirection: 'column',
        border: '4px solid black',
        padding: '2vh 2vw',
        alignItems: 'center',
        justifyContent: 'center',
        overflowY: 'hidden',
        flex: '1',
        fontFamily: 'monospace'
      },
      child: {
        width: '500px'
      },
      button: {
        background: 'none',
        border: '4px solid black',
        fontFamily: 'monospace',
        fontSize: '1.5em',
        width: '20em',
        height: '3em',
        textAlign: 'center',
        cursor: 'pointer'
      }
    };

    return (
      <div style={styles.container}>
        <h1>Brutal Chat</h1>
        <p style={styles.child}>Brutal Chat is a real-time text chat. It's a space where the oppression of modern technology is always evident. Where messages are instantly forgotten, unless explicitly recorded. Where every mistake is exposed, but fleeting. A space to be brutally honest.</p>
        <p style={styles.child}>Here are some special things you can type to help you out:</p>
        <ul style={styles.child}>
          <li>"/join [room]" &mdash; change to a different chat room</li>
          <li>"/leave" &mdash; return to the default chat room</li>
          <li>"/record" &mdash; begin recording the conversation</li>
          <li>"/stop" &mdash; stop recording</li>
          <li>"/nick" &mdash; get a new nickname</li>
        </ul>
        <p>
          <button style={styles.button} onClick={this.props.enter}>Enter</button>
        </p>
      </div>
    );
  }
}

const mapDispatchToProps = (dispatch) => ({
  enter: () => dispatch(enter())
});

export default connect(null, mapDispatchToProps)(Welcome);
