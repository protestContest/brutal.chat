import React from 'react';
import { connect } from 'react-redux';
import { MESSAGE_TIMEOUT } from './Chat';

class MessageBox extends React.PureComponent {
  constructor(props) {
    super(props);
    this.state = { interval: null, percentLeft: 1 };
  }

  componentDidMount() {
    if (!this.props.ownMessage) return;

    const that = this;
    this.setState({
      interval: setInterval(() => {
        const timeLeft = this.props.timeout - Date.now();
        const percentLeft = timeLeft / MESSAGE_TIMEOUT;
        if (percentLeft < 0) {
          clearInterval(that.state.interval);
          that.setState({ percentLeft: 0, interval: null });
        } else {
          that.setState({ percentLeft });
        }
      }, 100)
    })
  }

  render() {
    const opacity = (this.props.ownMessage && this.props.isInput)
      ? (1 - this.state.percentLeft) * 0.5 + 0.5
      : 1;

    const borderColor = (this.props.message.recorded)
      ? `rgba(255, 0, 0, ${opacity}`
      : `rgba(0, 0, 0, ${opacity})`;

    const styles = {
      container: {
        margin: '1em 0',
        position: 'relative',
        alignSelf: (this.props.ownMessage)
          ? 'flex-start'
          : ''
      },
      title: {
        position: 'absolute',
        fontSize: '0.8em',
        background: 'white',
        top: '-0.4em',
        left: '0.8em',
        padding: '0 0.5em'
      },
      box: {
        display: 'inline-block',
        border: '4px solid ' + borderColor,
        padding: '0.75em',
        fontFamily: 'monospace',
        fontSize: '1.5em',
        minWidth: '20em',
        maxWidth: '30em',
        minHeight: '3em',
        wordBreak: 'break-all'
      }
    };

    return (
      <div style={styles.container}>
        <span style={styles.box} className='message-box'>
          <span style={styles.title}>{this.props.message.author}</span>
          {this.props.message.content}
        </span>
      </div>
    );
  }
}

const mapStateToProps = (state, ownProps) => {
  const message = state.messages.find((message) => message.id === ownProps.message);
  return ({
    message: message,
    user: state.user,
    recorded: ownProps.recorded,
    timeout: ownProps.timeout,
    ownMessage: message.author === state.user,
    isInput: message.id === state.inputMessage
  });
};

export default connect(mapStateToProps)(MessageBox);