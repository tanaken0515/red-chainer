# Red Chainer : A deep learning framework

A flexible framework for neural network for Ruby

## Description

It ported python's [Chainer](https://github.com/chainer/chainer) with Ruby.

## Requirements

* Ruby 2.3 or later

## Installation

Add this line to your application's Gemfile:

```bash
gem 'red-chainer'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install red-chainer
```

## Usage
MNIST sample program is [here](./examples/mnist/mnist.rb)

```bash
# when install Gemfile
$ bundle exec ruby examples/mnist/mnist.rb
# when install yourself
$ ruby examples/mnist/mnist.rb
```

## License

The MIT license. See [LICENSE.txt](./LICENSE.txt) for details.

## Red Chainer implementation status

|    |  Chainer 2.0<br>(Initial ported version)  | Red Chainer (0.3.1) | example |
| ---- | ---- | ---- | ---- |
|  [activation](https://github.com/red-data-tools/red-chainer/tree/master/lib/chainer/functions/activation)  |  15  | 5 | LogSoftmax, ReLU, LeakyReLU, Sigmoid, Tanh |
|  [loss](https://github.com/red-data-tools/red-chainer/tree/master/lib/chainer/functions/loss)  |  17  | 2 | SoftMax, MeanSquaredError |
|  [optimizer](https://github.com/red-data-tools/red-chainer/tree/master/lib/chainer/optimizers)  |  9  | 2 | Adam, MomentumSGDRule |
|  [connection](https://github.com/red-data-tools/red-chainer/tree/master/lib/chainer/functions/connection)  |  12  | 2 | Linear, Convolution2D |
|  [pooling](https://github.com/red-data-tools/red-chainer/tree/master/lib/chainer/functions/pooling)  |  14  | 3 | Pooling2D, MaxPooling2D, AveragePooling2D |
|  [example](https://github.com/red-data-tools/red-chainer/tree/master/examples)  |  31  | 3 | MNIST, Iris, CIFAR |
|  GPU  | use cupy  | ToDo | want to support [Cumo](https://github.com/sonots/cumo) |
