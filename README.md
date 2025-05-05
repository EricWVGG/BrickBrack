# BrickWall

BrickWall is a SwiftUI Layout library. It creates a “masonry” layout that supports bricks in mixed horizontal and vertical orientations.

## Release notes

This was put together for a project I’m working on, so documentation and examples are pretty sparse for the time being. Although it should work okay, this is technically pre-release.

## Usage

```
BrickWall(gapX: 24, gapY: 24, columnCount: 5) {
    Text("This is a 1x1 brick that will automatically insert into the first empty 1x1 space.")
        .gridCell(
            Brick(columns: 1, rows: 1)
        )

    Text("This is a 2x1 brick that will automatically insert into the first empty 2x1 space.")
        .gridCell(
            Brick(columns: 2, rows: 1)
        )    

    Text("This is a 2x1 brick, placed at origin 0,0.")
        .gridCell(
            Brick(columns: 2, rows: 1, x: 0, y: 0)
        )
    
    Text("This is a 1x2 brick, placed at origin 2,0.")
        .gridCell(
            Brick(columns: 1, rows: 2, x: 2, y: 0)
        )
    
    Text("This is a 3x1 brick, placed at origin 3,1.")
        .gridCell(
            Brick(columns: 3, rows: 1, x: 3, y: 1)
        )
    
}
```

## Near-future enhancements

More demos and examples, and some animated images in this README doc.

## Future enhancements

This layout takes a predetermined number of columns, then grows vertically to accomodate the content. It should be enhanced to take a number of rows instead, and grow horizontally (basically, the axis should pivot).

I’d like to dream up some way to automatically generate cell sizes (i.e. determine that a very wide image would fit 5x1, or whatever).

The foundation of the grid is square. Perhaps it should take rectangular or irregular cells?.

Could this place L's and "tetronimos" and other oddly-shaped bricks?
