# %%
## Apriori algorithm
import pandas as pd
from pandas import DataFrame
import itertools

# %%
def conv(val):
        if val == 't':
            return 1
        else:
            return 0
        
class CSVLoader():
    def __init__(self) -> None:
        pass
    # load csv

    def load_csv(self, csv_name: str) -> DataFrame:
        self.column_list = pd.read_csv(csv_name, index_col=0, nrows=0).columns.tolist()
        csv_header_len = len(self.column_list) + 1
        csv_file = pd.read_csv(csv_name, engine="python", converters={k: conv for k in range(csv_header_len)})
        return csv_file

# %%
class Apriori():

    def __init__(self, support: float, confidence: float, csv_name: str) -> None:
        csv_loader = CSVLoader()
        self.data = csv_loader.load_csv(csv_name=csv_name)
        self.min_support = support
        self.confidence = confidence
        self.row_count = len(self.data.index)

    def calculate_support(self, data: DataFrame) -> dict:
        support_count = {item:0 for item in data.columns}
        for column in data.columns:
            support_count[column] = data[column].value_counts()[1]/self.row_count
        return support_count

    def prune(self, current_combinations: list, previous_frequent_combinations: list, previous_length: int) -> list:
        # remove all items from set that are not part of previous frequent list
        # combinations = [(1,2,3), ... , (1,2,3)]
        new_combinations_list = current_combinations
        previous_frequent_combinations = set(previous_frequent_combinations)
        for index, item in enumerate(current_combinations):
            temp_combinations = list(itertools.combinations(item, previous_length))
            for prev_item in temp_combinations:
                temp_set = set(prev_item)
                if not temp_set.issubset(previous_frequent_combinations):
                    new_combinations_list.pop(index)
                    break
        return new_combinations_list

    def above_min_support(self, frequency_dict: dict) -> list:
        above_min_support = []
        for key in frequency_dict.keys():
            if frequency_dict[key] > self.min_support:
                above_min_support.append(key)
        return above_min_support

    def apriori(self) -> list:
        #Run apriori
        #read file and format
        c1 = self.calculate_support(self.data)
        l1 = self.above_min_support(c1)
        # print(l1)

        accumulated_frequent_dataset = {}

        current_lset = l1
        current_iteration = 2
        test = True
        while current_lset and test:
            #store frequent item set
            accumulated_frequent_dataset[current_iteration - 1] = current_lset
            print(len(current_lset))
            # create combinations
            combinations = list(itertools.combinations(current_lset, current_iteration))
            # print(len(combinations))
            # prune
            combinations = self.prune(current_combinations=combinations, previous_frequent_combinations=current_lset, previous_length=current_iteration-1)
            # calculate above min support
            current_c = {}
            count = 0
            for item in combinations:
                for row, row_data in self.data.iterrows():
                    add_frequency = True
                    for member in item:
                        if not row_data[member]:
                            add_frequency = False
                            break
                    if add_frequency:
                        count += 1
                current_c[item] = count
                print(current_c)
                count = 0
            print(current_c)
            # current lset from here
            current_iteration += 1
            # print(len(combinations))
            # print(accumulated_frequent_dataset)
            test = False
                
        return []# list of association rules

def main():
    support = 0.005
    confidence = 0.6
    csv_name = "./myDataFile.csv"
    apriori = Apriori(support=support, confidence=confidence, csv_name=csv_name)
    association_rules = apriori.apriori()
    # print(association_rules)

if __name__=="__main__":
    main()


