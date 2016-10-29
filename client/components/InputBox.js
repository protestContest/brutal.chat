import React from 'react';
import { connect } from 'react-redux';

class InputBox extends React.PureComponent {
  render() {
    const styles = {
      container: {
        margin: '1em 0',
        alignSelf: 'flex-start'
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
          {this.props.input}
        </span>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  input: state.input
});

export default connect(mapStateToProps)(InputBox);