# %%
## Apriori algorithm
import pandas as pd
from pandas import DataFrame
import itertools
import numpy as np
from collections.abc import Iterable

# %%
def conv(val):
        if val == 't':
            return 1
        else:
            return 0

def find_subset(item, item_length):
    combs = []
    for i in range(1, item_length + 1):
        combs.append(list(itertools.combinations(item, i)))
        
    subsets = []
    for comb in combs:
        for elt in comb:
            subsets.append(elt)
            
    return subsets


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

    def prune(self, current_combinations: Iterable, previous_frequent_combinations: list, previous_length: int) -> list:
        # remove all items from set that are not part of previous frequent list
        # combinations = [(1,2,3), ... , (1,2,3)]
        new_combinations_list = []
        if previous_length == 1:
            previous_frequent_combinations = [{item} for item in previous_frequent_combinations]
        for index, item in enumerate(current_combinations):
            temp_combinations = list(itertools.combinations(item, previous_length))
            for prev_item in temp_combinations:
                temp_set = set(prev_item)
                if temp_set in previous_frequent_combinations:
                    new_combinations_list.append(item)   
        return new_combinations_list

    def above_min_support(self, frequency_dict: dict) -> list:
        above_min_support = [{key: support} for key, support in frequency_dict.items() if support > self.min_support]
        return above_min_support

    def apriori(self) -> list:
        c1 = self.calculate_support(self.data)
        l1 = self.above_min_support(c1)

        accumulated_frequent_dataset = {}

        current_lset = l1
        current_iteration = 2
        while current_lset:
            print(len(current_lset))

            accumulated_frequent_dataset[current_iteration - 1] = current_lset
            # create combinations
            if current_iteration - 1 == 1:
                current_lset = list(set(list(np.array([list(item.keys()) for item in current_lset]).ravel())))
            else:
                new_lset = []
                for item in current_lset:
                    for key in item.keys():
                        temp_keys = {new_item for new_item in key}
                        new_lset.append(temp_keys)
                current_lset = new_lset
            # print(current_lset)
            if current_iteration == 2:
                combinations = itertools.combinations(current_lset, current_iteration)
            else:
                new_combinations = []
                for item_test in current_lset:
                    for sub_item_test in current_lset:
                        union_set = item_test.union(sub_item_test)
                        # print(union_set)
                        if len(union_set) == current_iteration:
                            new_combinations.append(tuple(union_set))
                
                combinations =  [frozenset(s) for s in new_combinations]
                combinations = set(combinations)
                combinations = [set(item) for item in combinations]
                combinations = [tuple(item) for item in combinations]
            combinations = self.prune(current_combinations=combinations, previous_frequent_combinations=current_lset, previous_length=current_iteration-1)
            # calculate above min support
            current_c = {}
            count = 0
            for item in combinations:
                condition = np.all(self.data[list(item)], axis=1)
                count = np.sum(condition)
                current_c[item] = count/self.row_count
                count = 0
            current_lset = self.above_min_support(current_c)
            current_iteration += 1
        return accumulated_frequent_dataset

    def association_rules(self, acc_dataset: dict) -> None:
        rules = list()
        for item, support in acc_dataset.items():
            item_length = len(item)
            
            if item_length > 1:
                subsets = find_subset(item, item_length)
            
                for A in subsets:
                    B = item.difference(A)
                
                    if B:
                        A = frozenset(A)
                        
                        AB = A | B
                        
                        confidence = acc_dataset[AB] / acc_dataset[A]
                        if confidence >= self.confidence:
                            rules.append((A, B, confidence))

        # print(rules)
        print("Number of rules: ", len(rules), "\n")

        for rule in rules:
            print('{0} -> {1} <confidence: {2}>'.format(set(rule[0]), set(rule[1]), rule[2]))

def main():
    support = 0.005
    confidence = 0.6
    csv_name = "./myDataFile.csv"
    apriori = Apriori(support=support, confidence=confidence, csv_name=csv_name)
    acc_dataset = apriori.apriori()
    result_dict = {}
    for i in range(1,len(acc_dataset) + 1):
        # print(i)
        for sub_item in acc_dataset[i]:
            # print(frozenset(sub_item.keys()))
            result_dict.update(sub_item)
    processed_result_dict = {}
    for key in result_dict.keys():
        new_tuple = key
        if isinstance(key,str):
            new_tuple = [key]
        processed_result_dict[frozenset(new_tuple)] = result_dict[key]
    # print(processed_result_dict)
    apriori.association_rules(processed_result_dict)


if __name__=="__main__":
    main()


