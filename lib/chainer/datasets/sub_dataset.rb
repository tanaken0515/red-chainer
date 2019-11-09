module Chainer
  module Datasets
    class SubDataset < Chainer::Dataset::DatasetMixin
      def initialize(dataset, start, finish, order: nil)
        @dataset = dataset
        @start = start
        @finish = finish
        @size = finish - start

        if order and order.size != dataset.size
          raise ArgumentError, <<~EOS
            order option must have the same length as the base dataset: 
            order.size = #{order.size} while len(dataset) = #{dataset.size}
          EOS
        end
        @order = order
      end

      def size
        @size
      end

      def get_example(index)
        if index >= 0
          if index >= @size
            raise IndexError, 'dataset index out of range'
          end
          index = @start + 1
        else
          if index < -1 * @size
            raise IndexError, 'dataset index out of range'
          end
          index = @finish + 1
        end

        index = @order[index] if @order

        @dataset[index]
      end
    end

    def self.split_dataset(dataset, split_at, order: nil)
      n_examples = dataset.size

      raise ArgumentError, "split_at must be int, got #{split_at.class} instead" unless split_at&.integer?
      raise ArgumentError, 'split_at must be non-negative' if split_at < 0
      raise ArgumentError, 'split_at exceeds the dataset size' if split_at > n_examples

      subset1 = SubDataset.new(dataset, 0, split_at, order: order)
      subset2 = SubDataset.new(dataset, split_at, n_examples, order: order)

      [subset1, subset2]
    end

    def self.split_dataset_random(dataset, first_size, seed: nil)
      order = (0...dataset.size).to_a.shuffle # instead of `np.random.RandomState(seed).permutation(len(dataset))`
      split_dataset(dataset, first_size, order: order)
    end
  end
end
