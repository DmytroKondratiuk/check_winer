# frozen_string_literal: true

class BetCheker
  attr_reader :result, :bet

  def initialize(result:, bet:)
    @result = result
    @bet = bet
  end

  def result_of_bet
    return 'Invalid result or bet inputs' unless correct_inputs?
    return 1 if right_result?
    return 0 if right_final_result?

    -1
  end

  private

  def result_array
    @result_array ||= result.split(':')
  end

  def bet_array
    @bet_array ||= bet.split(':')
  end

  def correct_inputs?
    result_array.size == 2 && bet_array.size == 2 && correct_inputs_values?
  end

  def correct_inputs_values?
    (result_array + bet_array).all? { |value| correct_value?(value) }
  end

  def correct_value?(value)
    /^\d+$/.match?(value) && value.to_i >= 0
  end

  def right_result?
    result_array[0].to_i == bet_array[0].to_i && result_array[1].to_i == bet_array[1].to_i
  end

  def right_final_result?
    (final_result >= 0) && (bet_outcome >= 0)
  end

  def final_result
    outcome(result_array)
  end

  def bet_outcome
    outcome(bet_array)
  end

  def outcome(outcome_array)
    outcome_array[0].to_i - outcome_array[1].to_i
  end
end
