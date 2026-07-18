# IEEE-754 Hardware Multiplier 
* Developed discrete combinational RTL modules to execute standard floating-point arithmetic, including a 53-bit multiplier yielding a 106-bit mantissa product,
an 11-bit exponent adder with 1023 bias subtraction, and XOR-based sign logic. Engineered a robust hardware exception-handling unit that systematically classifies inputs and resolves critical IEEE-754 edge cases, ensuring mathematical stability for Not-a-Number (NaN), Infinity, zero, overflow, and underflow.
* Optimized the critical path for final product generation by routing the normalized outputs and exception flags through a custom 5-to-1 multiplexer , ensuring deterministic data selection with zero latch inference.
