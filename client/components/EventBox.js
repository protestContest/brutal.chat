import React from 'react';
import { connect } from 'react-redux';

class EventBox extends React.PureComponent {
  render() {
    const styles = {
      margin: '1em 0',
      alignSelf: 'center',
      color: '#777',
      fontFamily: 'monospace',
      textTransform: 'uppercase'
    };

    return (
      <div style={styles}>
        &mdash; {this.props.event.content} &mdash;
      </div>
    );
  }
}

const mapStateToProps = (state, ownProps) => ({
  event: state.events.find(event => event.id === ownProps.event)
});

export default connect(mapStateToProps)(EventBox);