@value
struct Combiner():
    var val: Int

    def combine(self, x: Int) -> Self:
        """ Combine values.

        # Arguments
        x: int. Value to combine.

        # Example
        ```mojo
        %# from combiner import Combiner
        %# from testing import assert_equal

        var c = Combiner(0)
        assert_equal(c.combine(1).combine(2).val, 3)
        ```
        """

        return Self(self.val + x)