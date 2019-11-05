module Chainer
  module Dataset
    class DatasetMixin
      def [](index)
        if index.kind_of?(Enumerable)
          # python:
          #   current, stop, step = index.indices(len(self))
          #   [self.get_example(i) for i in six.moves.range(current, stop, step)]
          raise NotImplementedError
        elsif Chainer.array?(index)
          (0...index.size).map {|i| get_example(i)}
        else
          get_example(index)
        end
      end

      def size
        raise NotImplementedError
      end

      def get_example(index)
        raise NotImplementedError
      end
    end
  end
end
