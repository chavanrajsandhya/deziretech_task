describe AirlineSeating do
  describe 'method#initialize' do
    context 'check if the input arguments are valid or not' do
      describe 'method#validate_input' do
        context 'when input blank' do
          let(:lines) { [] }
          let!(:blank_message) { 'Please provide input: A 2D array and the Number of passengers!' }
          it "returns a proper validation message" do
            obj = AirlineSeating.new(lines)
            expect(obj.message).not_to be_nil
            expect(obj.message).to eql(blank_message)
          end
        end

        context 'when either of the 2 inputs is blank' do
          let(:first_lines) { ["", "59"] }
          let!(:first_blank_message) { 'Please provide a 2D array as the first argument!' }
          let(:second_lines) { ["1,2,3", ""] }
          let!(:second_blank_message) { 'Please provide the Number of passengers as the second argument!' }

          it "returns a proper validation message when the first argument is blank" do
            obj = AirlineSeating.new(first_lines)
            expect(obj.message).not_to be_nil
            expect(obj.message).to eql(first_blank_message)
          end

          it "returns a proper validation message when the second argument is blank" do
            obj = AirlineSeating.new(second_lines)
            expect(obj.message).not_to be_nil
            expect(obj.message).to eql(second_blank_message)
          end
        end

        context 'when the 2D array is not valid' do
          let(:lines_first_arg_not_all_are_arrays) { ["[[3,2],2,[4],[3,4]]", "59"] }
          let!(:message_1) { 'The given array is not in 2D format!' }
          let(:lines_first_arg_not_all_arrays_with_xy_format) { ["[[3,2],[2],[4,3,4],[3,4]]", "59"] }
          let!(:message_2) { 'All the sub-arrays of the given 2D array are not of [x,y] format!' }
          let(:lines_first_arg_sub_arrays_with_zeros) { ["[[3,2],[2,0],[4,3],[3,4]]", "59"] }
          let!(:message_3) { "The sub-arrays are in [x,y] format but 'x' and 'y' should be NON-ZERO values!" }

          it "returns a proper validation message when any element of the given 2D array is not an array" do
            obj = AirlineSeating.new(lines_first_arg_not_all_are_arrays)
            expect(obj.message).not_to be_nil
            expect(obj.message).to eql(message_1)
          end

          it "returns a proper validation message when any element of the given 2D array is not an array of [x,y] format" do
            obj = AirlineSeating.new(lines_first_arg_not_all_arrays_with_xy_format)
            expect(obj.message).not_to be_nil
            expect(obj.message).to eql(message_2)
          end

          it "returns a proper validation message when any sub array element contain x or y values as zero" do
            obj = AirlineSeating.new(lines_first_arg_sub_arrays_with_zeros)
            expect(obj.message).not_to be_nil
            expect(obj.message).to eql(message_3)
          end
        end

        context 'when the 2nd argument is not an integer' do
          let(:lines) { ["[[3,2],[2,5],[4,8],[3,4]]", "[59]"] }
          let!(:message) { 'The second argument should be a positive integer' }

          it "returns a proper validation message the 2nd argument is not an integer" do
            obj = AirlineSeating.new(lines)
            expect(obj.message).not_to be_nil
            expect(obj.message).to eql(message)
          end
        end

        context 'when both the inputs are correct' do
          let(:lines) { ["[[3,2],[2,5],[4,8],[3,4]]", "59"] }

          it "returns no validation message" do
            obj = AirlineSeating.new(lines)
            expect(obj.message).to be_nil
          end
        end
      end
    end

    context 'check if the instance is getting initialized with the required attributes' do
      let(:lines) { ["[[3,2],[2,5],[4,8],[3,4]]", "59"] }
      let(:max_seats) { (3*2) + (2*5) + (4*8) + (3*4) }

      it "sets the maximum seats available" do
        obj = AirlineSeating.new(lines)
        expect(obj.max_seats).not_to be_nil
        expect(obj.max_seats).to equal(max_seats)
      end

      it "sets the passengers count" do
        obj = AirlineSeating.new(lines)
        expect(obj.passengers_count).not_to be_nil
        expect(obj.passengers_count).to equal(59)
      end
    end
  end
end
