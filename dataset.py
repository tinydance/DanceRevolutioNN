import numpy as np
import torch
import torch.utils.data
from torch.utils.data import Dataset


def paired_collate_fn(insts):
    print("test4")
    src_seq, tgt_seq = list(zip(*insts))
    src_pos = np.array([[pos_i + 1 for pos_i, v_i in enumerate(inst)] for inst in src_seq])

    src_seq = torch.FloatTensor(src_seq)
    src_pos = torch.LongTensor(src_pos)
    tgt_seq = torch.FloatTensor(tgt_seq)

    return src_seq, src_pos, tgt_seq


class DanceDataset(Dataset):
    def __init__(self, musics, dances=None):
        print("test3")
        if dances is not None:
            assert (len(musics) == len(dances)), \
                'the number of dances should be equal to the number of musics'
        self.musics = musics
        self.dances = dances
        print("test5")

    def __len__(self):
        return len(self.musics)

    def __getitem__(self, index):
        if self.dances is not None:
            return self.musics[index], self.dances[index]
        else:
            return self.musics[index]
