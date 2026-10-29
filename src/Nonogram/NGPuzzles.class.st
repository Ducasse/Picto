"
I am the catalog of built-in puzzles.

## Responsibility:

- I define each built-in puzzle in a class-side method.
- I tag each of these methods with the `<puzzle>` pragma so it can be discovered.
- I offer puzzles from 3 x 3 (`#plus`) to 20 x 20 (`#greatLighthouse`, `#greatBalloon`).

## Collaborators:

- `NGPuzzleLibrary class >> #default` collects my `<puzzle>` methods.
- `NGPuzzle` is what each of my methods answers.

## Public API and Key Messages

- Class-side puzzle methods, such as `#plus`, `#heart`, `#greatLighthouse`.

```
NGPuzzles heart
```

## Internal Representation

I have no state.

### Implementation Points

- To add a puzzle, add a class-side method with the `<puzzle>` pragma answering an `NGPuzzle`; `NGPuzzlesTest` checks it has a single solution.
"
Class {
	#name : 'NGPuzzles',
	#superclass : 'Object',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'puzzles' }
NGPuzzles class >> bandedBalloon [
	<puzzle>
	^ NGPuzzle
		named: 'Banded balloon'
		fromStrings: #(
			'.....#####.....'
			'...#########...'
			'..###########..'
			'.#############.'
			'.#############.'
			'.##.........##.'
			'.#############.'
			'..###########..'
			'...#########...'
			'....#######....'
			'.....#...#.....'
			'......#.#......'
			'......###......'
			'......###......'
			'...............' )
]

{ #category : 'puzzles' }
NGPuzzles class >> boat [
	<puzzle>
	^ NGPuzzle
		named: 'Boat'
		fromStrings: #(
			'.......#.......'
			'.......##......'
			'.......###.....'
			'.......####....'
			'.......#####...'
			'.......######..'
			'.......#.......'
			'.......#.......'
			'###############'
			'.#############.'
			'..###########..'
			'...#########...'
			'#.#.#.#.#.#.#.#'
			'.#.#.#.#.#.#.#.'
			'...............' )
]

{ #category : 'puzzles' }
NGPuzzles class >> cat [
	<puzzle>
	^ NGPuzzle
		named: 'Cat'
		fromStrings: #(
			'...............'
			'..#.........#..'
			'..##.......##..'
			'..###.....###..'
			'..###########..'
			'.#############.'
			'.##..#####..##.'
			'.##..#####..##.'
			'.#############.'
			'.######.######.'
			'.#####...#####.'
			'..###.#.#.###..'
			'...#########...'
			'.....#####.....'
			'...............' )
]

{ #category : 'puzzles' }
NGPuzzles class >> greatBalloon [
	<puzzle>
	^ NGPuzzle
		named: 'Great balloon'
		fromStrings: #(
			'.......######.......'
			'....############....'
			'...###.######.###...'
			'..####.######.####..'
			'.#####.######.#####.'
			'.#####.######.#####.'
			'######.######.######'
			'######.######.######'
			'######.######.######'
			'.#####.######.#####.'
			'.#####.######.#####.'
			'..####.######.####..'
			'...###.######.###...'
			'....##.######.##....'
			'.....#.######.#.....'
			'......#......#......'
			'.......#....#.......'
			'........####........'
			'........####........'
			'........####........' )
]

{ #category : 'puzzles' }
NGPuzzles class >> greatLighthouse [
	<puzzle>
	^ NGPuzzle
		named: 'Great lighthouse'
		fromStrings: #(
			'.........##.........'
			'........####........'
			'###....######....###'
			'#####..#....#..#####'
			'###....######....###'
			'........####........'
			'........####........'
			'.......######.......'
			'.......##..##.......'
			'.......######.......'
			'.......######.......'
			'......########......'
			'......##....##......'
			'......########......'
			'......########......'
			'.....##########.....'
			'.....###....###.....'
			'....############....'
			'..################..'
			'####################' )
]

{ #category : 'puzzles' }
NGPuzzles class >> heart [
	<puzzle>
	^ NGPuzzle named: 'Heart' fromStrings: #('.##.##.' '#######' '#######' '.#####.' '..###..' '...#...')
]

{ #category : 'puzzles' }
NGPuzzles class >> house [
	<puzzle>
	^ NGPuzzle named: 'House' fromStrings: #('...#...' '..###..' '.#####.' '#######' '.#...#.' '.#.#.#.' '.#.#.#.' '.#####.')
]

{ #category : 'puzzles' }
NGPuzzles class >> lighthouse [
	<puzzle>
	^ NGPuzzle
		named: 'Lighthouse'
		fromStrings: #(
			'......###......'
			'##...#####...##'
			'####.#...#.####'
			'##...#####...##'
			'.....#####.....'
			'......###......'
			'......###......'
			'.....#####.....'
			'.....#...#.....'
			'.....#####.....'
			'....#######....'
			'....#.....#....'
			'....#######....'
			'...#########...'
			'###############' )
]

{ #category : 'puzzles' }
NGPuzzles class >> plus [
	<puzzle>
	^ NGPuzzle named: 'Plus' fromStrings: #('.#.' '###' '.#.')
]

{ #category : 'puzzles' }
NGPuzzles class >> rockLighthouse [
	<puzzle>
	^ NGPuzzle
		named: 'Rock lighthouse'
		fromStrings: #(
			'.......#.......'
			'......###......'
			'.....#####.....'
			'......###......'
			'......#.#......'
			'......###......'
			'.....##.##.....'
			'.....#####.....'
			'.....##.##.....'
			'....#######....'
			'....##...##....'
			'...#########...'
			'..###########..'
			'.#.#.#.#.#.#.#.'
			'#.#.#.#.#.#.#.#' )
]

{ #category : 'puzzles' }
NGPuzzles class >> stripedBalloon [
	<puzzle>
	^ NGPuzzle
		named: 'Striped balloon'
		fromStrings: #(
			'....#######....'
			'..###.###.###..'
			'.####.###.####.'
			'.####.###.####.'
			'#####.###.#####'
			'#####.###.#####'
			'#####.###.#####'
			'.####.###.####.'
			'..###.###.###..'
			'...##.###.##...'
			'....#.###.#....'
			'.....#...#.....'
			'......#.#......'
			'......###......'
			'......###......' )
]
