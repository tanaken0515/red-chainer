module Chainer
  module Functions
    module Array
      # Select elements stored in given indices.
      class SelectItem < FunctionNode
        # Select elements stored in given indices.
        #  This function returns $t.choose(x.T)$, that means
        #  $y[i] == x[i, t[i]]$ for all $i$.
        #
        #  @param [Chainer::Variable] x Variable storing arrays.
        #  @param [Chainer::Variable] t Variable storing index numbers.
        #  @return [Chainer::Variable] Variable that holds $t$-th element of $x$.
        def self.select_item(x, t)
          SelectItem.new.apply([x, t]).first
        end

        def forward(inputs)
          retain_inputs([1])
          x, t = inputs
          @in_shape = x.shape
          @in_dtype = x.class

          return [x.class.zeros(0)] if t.size == 0

          # x[six.moves.range(t.size), t]
          [x[true, t].diagonal.dup]
        end

        def backward(indexes, gy)
          t = get_retained_inputs.first
          ret = []
          if indexes.include?(0)
            ggx = Assign.new(@in_shape, @in_dtype, t).apply(gy).first
            ret << ggx
          end
          if indexes.include?(1)
            ret << nil
          end
          ret
        end
      end

      class Assign < FunctionNode
        def initialize(shape, dtype, t)
          @shape = shape
          @dtype = dtype
          @t = t.data
        end

        def forward(inputs)
          gx = @dtype.zeros(*@shape)

          # gx[six.moves.range(self.t.size), self.t] = inputs[0]
          gx.at((0...@t.size).to_a, @t)[true] = inputs[0] unless @t.empty?

          [gx]
        end

        def backward(indexes, gy)
          SelectItem.new.apply([gy[0], @t])
        end
      end
    end
  end
end
