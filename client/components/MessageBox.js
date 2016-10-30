import React from 'react';
import { connect } from 'react-redux';

class MessageBox extends React.PureComponent {
  render() {
    const styles = {
      container: {
        margin: '1em 0',
        position: 'relative',
        alignSelf: (this.props.message.author === this.props.user)
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
        border: '4px solid black',
        padding: '0.75em',
        fontFamily: 'monospace',
        fontSize: '20px',
        minWidth: '20em',
        maxWidth: '30em'
      }
    };

    return (
      <div style={styles.container}>
        <span style={styles.box}>
          <span style={styles.title}>{this.props.message.author}</span>
          {this.props.message.content}
        </span>
      </div>
    );
  }
}

const mapStateToProps = (state, ownProps) => {

  return ({
    message: state.messages.find((message) => message.id === ownProps.message),
    user: state.user
  });
};

export default connect(mapStateToProps)(MessageBox);