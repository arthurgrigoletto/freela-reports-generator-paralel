defmodule FreelaReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    response = FreelaReportsGenerator.build("report_test.csv")

    expected_response = %{
      "all_hours" => %{
        "cleiton" => 1,
        "daniele" => 12,
        "danilo" => 0,
        "diego" => 0,
        "giuliano" => 9,
        "jakeliny" => 14,
        "joseph" => 3,
        "mayk" => 5,
        "rafael" => 0,
        "vinicius" => 0
      },
      "hours_per_month" => %{
        "cleiton" => %{
          "abril" => 0,
          "agosto" => 0,
          "dezembro" => 0,
          "fevereiro" => 0,
          "janeiro" => 0,
          "julho" => 0,
          "junho" => 1,
          "maio" => 0,
          "março" => 0,
          "novembro" => 0,
          "outubro" => 0,
          "setembro" => 0
        },
        "daniele" => %{
          "abril" => 7,
          "agosto" => 0,
          "dezembro" => 5,
          "fevereiro" => 0,
          "janeiro" => 0,
          "julho" => 0,
          "junho" => 0,
          "maio" => 0,
          "março" => 0,
          "novembro" => 0,
          "outubro" => 0,
          "setembro" => 0
        },
        "danilo" => %{
          "abril" => 0,
          "agosto" => 0,
          "dezembro" => 0,
          "fevereiro" => 0,
          "janeiro" => 0,
          "julho" => 0,
          "junho" => 0,
          "maio" => 0,
          "março" => 0,
          "novembro" => 0,
          "outubro" => 0,
          "setembro" => 0
        },
        "diego" => %{
          "abril" => 0,
          "agosto" => 0,
          "dezembro" => 0,
          "fevereiro" => 0,
          "janeiro" => 0,
          "julho" => 0,
          "junho" => 0,
          "maio" => 0,
          "março" => 0,
          "novembro" => 0,
          "outubro" => 0,
          "setembro" => 0
        },
        "giuliano" => %{
          "abril" => 0,
          "agosto" => 0,
          "dezembro" => 0,
          "fevereiro" => 9,
          "janeiro" => 0,
          "julho" => 0,
          "junho" => 0,
          "maio" => 0,
          "março" => 0,
          "novembro" => 0,
          "outubro" => 0,
          "setembro" => 0
        },
        "jakeliny" => %{
          "abril" => 0,
          "agosto" => 0,
          "dezembro" => 0,
          "fevereiro" => 0,
          "janeiro" => 0,
          "julho" => 8,
          "junho" => 0,
          "maio" => 0,
          "março" => 6,
          "novembro" => 0,
          "outubro" => 0,
          "setembro" => 0
        },
        "joseph" => %{
          "abril" => 0,
          "agosto" => 0,
          "dezembro" => 0,
          "fevereiro" => 0,
          "janeiro" => 0,
          "julho" => 0,
          "junho" => 0,
          "maio" => 0,
          "março" => 3,
          "novembro" => 0,
          "outubro" => 0,
          "setembro" => 0
        },
        "mayk" => %{
          "abril" => 0,
          "agosto" => 0,
          "dezembro" => 5,
          "fevereiro" => 0,
          "janeiro" => 0,
          "julho" => 0,
          "junho" => 0,
          "maio" => 0,
          "março" => 0,
          "novembro" => 0,
          "outubro" => 0,
          "setembro" => 0
        },
        "rafael" => %{
          "abril" => 0,
          "agosto" => 0,
          "dezembro" => 0,
          "fevereiro" => 0,
          "janeiro" => 0,
          "julho" => 0,
          "junho" => 0,
          "maio" => 0,
          "março" => 0,
          "novembro" => 0,
          "outubro" => 0,
          "setembro" => 0
        },
        "vinicius" => %{
          "abril" => 0,
          "agosto" => 0,
          "dezembro" => 0,
          "fevereiro" => 0,
          "janeiro" => 0,
          "julho" => 0,
          "junho" => 0,
          "maio" => 0,
          "março" => 0,
          "novembro" => 0,
          "outubro" => 0,
          "setembro" => 0
        }
      },
      "hours_per_year" => %{
        "cleiton" => %{"2016" => 0, "2017" => 0, "2018" => 0, "2019" => 0, "2020" => 1},
        "daniele" => %{"2016" => 5, "2017" => 0, "2018" => 7, "2019" => 0, "2020" => 0},
        "danilo" => %{"2016" => 0, "2017" => 0, "2018" => 0, "2019" => 0, "2020" => 0},
        "diego" => %{"2016" => 0, "2017" => 0, "2018" => 0, "2019" => 0, "2020" => 0},
        "giuliano" => %{"2016" => 0, "2017" => 3, "2018" => 0, "2019" => 6, "2020" => 0},
        "jakeliny" => %{"2016" => 0, "2017" => 8, "2018" => 0, "2019" => 6, "2020" => 0},
        "joseph" => %{"2016" => 0, "2017" => 3, "2018" => 0, "2019" => 0, "2020" => 0},
        "mayk" => %{"2016" => 0, "2017" => 1, "2018" => 0, "2019" => 4, "2020" => 0},
        "rafael" => %{"2016" => 0, "2017" => 0, "2018" => 0, "2019" => 0, "2020" => 0},
        "vinicius" => %{"2016" => 0, "2017" => 0, "2018" => 0, "2019" => 0, "2020" => 0}
      }
    }

    assert response == expected_response
  end

  describe "build_from_many/1" do
    test "should build the report when file list is provided" do
      filenames = ["report_test.csv", "report_test.csv"]
      response = FreelaReportsGenerator.build_from_many(filenames)

      expected_response =
        {:ok,
         %{
           "all_hours" => %{
             "cleiton" => 2,
             "daniele" => 24,
             "danilo" => 0,
             "diego" => 0,
             "giuliano" => 18,
             "jakeliny" => 28,
             "joseph" => 6,
             "mayk" => 10,
             "rafael" => 0,
             "vinicius" => 0
           },
           "hours_per_month" => %{
             "cleiton" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 2,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "daniele" => %{
               "abril" => 14,
               "agosto" => 0,
               "dezembro" => 10,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "danilo" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "diego" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "giuliano" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 18,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "jakeliny" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 16,
               "junho" => 0,
               "maio" => 0,
               "março" => 12,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "joseph" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 6,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "mayk" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 10,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "rafael" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "vinicius" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             }
           },
           "hours_per_year" => %{
             "cleiton" => %{"2016" => 0, "2017" => 0, "2018" => 0, "2019" => 0, "2020" => 2},
             "daniele" => %{"2016" => 10, "2017" => 0, "2018" => 14, "2019" => 0, "2020" => 0},
             "danilo" => %{"2016" => 0, "2017" => 0, "2018" => 0, "2019" => 0, "2020" => 0},
             "diego" => %{"2016" => 0, "2017" => 0, "2018" => 0, "2019" => 0, "2020" => 0},
             "giuliano" => %{"2016" => 0, "2017" => 6, "2018" => 0, "2019" => 12, "2020" => 0},
             "jakeliny" => %{"2016" => 0, "2017" => 16, "2018" => 0, "2019" => 12, "2020" => 0},
             "joseph" => %{"2016" => 0, "2017" => 6, "2018" => 0, "2019" => 0, "2020" => 0},
             "mayk" => %{"2016" => 0, "2017" => 2, "2018" => 0, "2019" => 8, "2020" => 0},
             "rafael" => %{"2016" => 0, "2017" => 0, "2018" => 0, "2019" => 0, "2020" => 0},
             "vinicius" => %{"2016" => 0, "2017" => 0, "2018" => 0, "2019" => 0, "2020" => 0}
           }
         }}

      assert response == expected_response
    end

    test "should return error when file list is not provider" do
      response = FreelaReportsGenerator.build_from_many("banana")

      expected_response = {:error, "Please provide a list of strings"}

      assert response == expected_response
    end
  end
end
