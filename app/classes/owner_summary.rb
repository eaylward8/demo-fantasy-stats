# frozen_string_literal: true

class OwnerSummary
  attr_reader :owner, :data

  def initialize(owner)
    @owner = owner
    records = OwnerRecords.new(@owner)
    @data = {
      title: owner_title_data,
      career: OwnerCareer.new(@owner).data,
      records: { game: records.data[:game], season: records.data[:season] },
      teams: @owner.teams_data,
      opponents: @owner.record_against_all.values
    }
  end

  def owner_title_data
    {
      id: owner.id,
      name: owner.name,
      seasons: owner.seasons_played,
      best_finish: owner.best_final_rank,
      worst_finish: owner.worst_final_rank,
      trophies: trophy_data
    }
  end

  def trophy_data
    {
      first: owner.teams_ranked(1),
      second: owner.teams_ranked(2),
      third: owner.teams_ranked(3)
    }
  end
end
