"
I am the catalog of built-in puzzles.

Responsibility: define each built-in puzzle in a class-side method tagged with the <puzzle> pragma.

Collaborators: NGPuzzleLibrary class >> #default collects my <puzzle> methods.

Public API and Key Messages: class-side puzzle methods, from 3 x 3 (#plus) to 20 x 20 (#greatLighthouse, #greatBalloon)

	NGPuzzles heart

Internal Representation and Key Implementation Points.

I have no state. To add a puzzle, add a class-side method with the <puzzle> pragma answering an NGPuzzle; NGPuzzlesTest checks it has a single solution.
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
NGPuzzles class >> lighthouseOnARock [
	<puzzle>
	^ NGPuzzle
		named: 'Lighthouse on a rock'
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
NGPuzzles class >> plus [
	<puzzle>
	^ NGPuzzle named: 'Plus' fromStrings: #('.#.' '###' '.#.')
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
