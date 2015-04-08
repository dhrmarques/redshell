require 'spec_helper'
require 'timecop'

require 'helpers'
include Helpers

describe "helpers/tasks_helper.rb" do

  $reference_time = next_week_day(Time.now, :sunday)
  context "when searching the tasks to create" do

    let(:reference_time) do
      $reference_time += 1.day
    end

    before :all do
      Timecop.freeze(next_week_day(Time.now, :sunday))

      @faxina = TaskType.create!(
          title: "Faxina",
          week_days: '0',
          each_n_weeks: 1,
          description: "Descrição da faxina",
          after_in_minutes: 680,
          before_in_minutes: 720          
        )

      @lixo = TaskType.create(
          title: "Retirada de lixo",
          week_days: '1',
          each_n_weeks: 1,
          description: "Descrição da retirada",
          after_in_minutes: 660,
          before_in_minutes: 680          
        )

      @lencois = TaskType.create(
          title: "Troca de lençóis",
          week_days: '2',
          each_n_weeks: 1,
          description: "Descrição da troca",
          after_in_minutes: 720,
          before_in_minutes: 780          
        )

      @troca = TaskType.create(
          title: "Troca de toalhas",
          week_days: '3',
          each_n_weeks: 1,
          description: "Descrição da troca",
          after_in_minutes: 720,
          before_in_minutes: 750          
        )

      @rega = TaskType.create(
          title: "Rega",
          week_days: '4',
          each_n_weeks: 1,
          description: "Descrição da rega",
          after_in_minutes: 330,
          before_in_minutes: 420          
        )

      @poda = TaskType.create(
          title: "Poda",
          week_days: '5',
          each_n_weeks: 1,
          description: "Descrição da poda",
          after_in_minutes: 360,
          before_in_minutes: 480          
        )

      @aparagem = TaskType.create(
          title: "Aparagem",
          week_days: '6',
          each_n_weeks: 1,
          description: "Descrição da aparagem",
          after_in_minutes: 480,
          before_in_minutes: 600          
        )

      @malandragem = TaskType.create(
          title: "Malandragem",
          week_days: '1',
          each_n_weeks: 2,
          description: "Descrição da aparagem",
          after_in_minutes: 480,
          before_in_minutes: 600          
        )

      @yay = TaskType.create(
          title: "Yay",
          week_days: '2',
          each_n_weeks: 3,
          description: "Descrição da aparagem",
          after_in_minutes: 480,
          before_in_minutes: 600          
        )

      @yay2 = TaskType.create(
          title: "Yay",
          week_days: '234',
          each_n_weeks: 3,
          description: "Descrição da aparagem",
          after_in_minutes: 480,
          before_in_minutes: 600          
        )
    end

    #Antes de cada teste, viaja-se para um dia novo. Tomar cuidado com a ordem dos testes
    context "first week" do
      it "sunday task_types" do
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(0)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@faxina])
      end

      it "monday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(1)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@lixo, @malandragem])
      end

      it "tuesday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(2)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@lencois, @yay, @yay2])
      end

      it "wednesday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(3)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@troca, @yay2])
      end

      it "thursday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(4)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@rega, @yay2])
      end

      it "friday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(5)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@poda])
      end

      it "saturday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(6)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@aparagem])
      end
    end

    context "second week" do
      it "sunday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(0)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@faxina])
      end

      it "monday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(1)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@lixo])
      end

      it "tuesday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(2)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@lencois])
      end

      it "wednesday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(3)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@troca])
      end

      it "thursday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(4)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@rega])
      end

      it "friday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(5)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@poda])
      end

      it "saturday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(6)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@aparagem])
      end
    end

    context "third week" do
      it "sunday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(0)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@faxina])
      end

      it "monday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(1)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@lixo, @malandragem])
      end

      it "tuesday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(2)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@lencois])
      end

      it "wednesday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(3)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@troca])
      end

      it "thursday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(4)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@rega])
      end

      it "friday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(5)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@poda])
      end

      it "saturday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(6)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@aparagem])
      end
    end

    context "fourth week" do
      it "sunday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(0)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@faxina])
      end

      it "monday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(1)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@lixo])
      end

      it "tuesday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(2)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@lencois, @yay, @yay2])
      end

      it "wednesday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(3)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@troca, @yay2])
      end

      it "thursday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(4)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@rega, @yay2])
      end

      it "friday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(5)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@poda])
      end

      it "saturday task_types" do 
        Timecop.travel(reference_time)
        got_result = TasksHelper.get_tasks_to_be_created(6)
        expect(tohash_and_filter(got_result)).to eq tohash_and_filter([@aparagem])
      end
    end

    after :all do
      TaskType.delete_all
    end

  end

end