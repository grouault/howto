[home](../../index-js.md)

## Dev Tools

## Redux Store

### principe
<pre>
* <b>configureStore</b> : requires that we pass in a <b>reducer</b> argument
* application : many features ; each feature have its own reducer function
* keyName in Object reducer define the keys in our final state value
* each keyName define a <b>section</b> of our redux state object
* keyName is associated with a <b>reducer</b>
* <b>reducer</b> : reducer function export from a file 'componentSlice.js'
</pre>

### store setup
<pre>
* redux allows store setup with different kind of plugins (middleware and enhancers)
* <b>configureStore</b> : automatically adds several middleware to the store
    * redux-thunk middleware
</pre>

## Redux Slice
<pre>
* slice : collection of Redux reducer logic and actions for a single feature in your app
* slice take care of the work of generating :
    * action type string  (slice name + key name of reducer function)
    * action creator : (same name that action creator function)
    * action objects (plain object with a type field) 
    * also generate reducer function that knows how to respond to all these action types
* slice need a initial state value for the reducers
</pre>

## Reducers

### Rules of reducers

### Reducers and Immutable Updates
<pre>
* createSlice use a library called Immer inside and lets you write immutable updates an easier way.
* Immmer use a proxy to wrap the data you provide and 
    lets you write code that mutates that wrapped data
* after, immer tracks all the changes you've tried to make ant then use that list 
    of change to return a safely immutably updated value
* immer detects changes to a draft state (dans le nouvel état)
</pre>

## ActionCreator

### ActionCreator and parameters
<pre>
* all reducer don't actually have their code look at the action object.
* it will be passed anyway but we can skip declaring action parameter
* <b>important</b> : parameter of ActionCreator is being put into the action payload
</pre>

## Thunk

### Definition
<pre>
* So far, all the logic in our application has been synchronous.
    * Actions are dispatched, 
    * the store runs the reducers and calculates the new state
    * the dispatch function finishes. 

* A thunk is a specific kind of Redux function that <b>can contain</b> asynchronous logic. 
* Thunks are written using two functions:
    * An inside thunk function, which gets <b>dispatch</b> and <b>getState</b> as arguments
    * The outside creator function, which creates and returns the thunk function

* Goal of async thunk :
    * execute async code
    * then dispatch an action    
</pre>

### Exemple 1 : thunk sync
<pre>
export const incrementIfOdd = (amount) => (dispatch, getState) => {
  const currentValue = selectCount(getState());
  if (currentValue % 2 === 1) {
    dispatch(incrementByAmount(amount));
  }
};
</pre>

### Exemple 2 : thunk async - call API Ajax
<pre>
// the outside "thunk creator" function
const fetchUserById = userId => {
  // the inside "thunk function"
  return async (dispatch, getState) => {
    try {
      // make an async call in the thunk
      const user = await userAPI.fetchById(userId)
      // dispatch an action when we get the response back
      dispatch(userLoaded(user))
    } catch (err) {
      // If something went wrong, handle it here
    }
  }
}
</pre>

## useSelector
<pre>
* reading datea
* lets our component extract whatever pieces of data it needs from the redux store state
* <b>"selector" functions</b>
    * take state as an argument 
    * return some part of the state value
* Our components can't talk to the Redux store directly, because we're not allowed 
    to import it into component files. But, useSelector takes care of talking 
    to the Redux store behind the scenes for us
*  <b> Important </b> :
     Any time an action has been dispatched and the Redux store has been updated, 
        useSelector will re-run our selector function. If the selector returns a different 
        value than last time, useSelector will make sure our component 
        <b>re-renders</b> with the new value.
</pre>