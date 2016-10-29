import React from 'react';

export default class MessageBox extends React.PureComponent {
  render() {
    const styles = {
      container: {
        margin: '1em 0'
      },
      box: {
        display: 'inline-block',
        border: '4px solid black',
        padding: '0.75em',
        fontFamily: 'monospace',
        fontSize: '20px',
        minWidth: '20em'
      }
    };

    return (
      <div style={styles.container}>
        <span style={styles.box}>
          {this.props.children}
        </span>
      </div>
    );
  }
}