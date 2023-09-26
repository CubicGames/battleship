module battleship::board_verifier {
    use sui::groth16;
    use sui::groth16::bn254;

    const VK_BYTES: vector<u8> = x"0343ce60c600436cd2cbe889789b6caea190b398cde5dffad5dd3e245931a9a04f8c9e550a353e5597be377e9c3ff5381df42b63fc52781450b0cbcec9a0f311";
    const ALPHA_BYTES: vector<u8> = x"d8655feed7ea6c98ab6829783590caa351a97a4d6408d05cfc780fc0a95b7812d798578043d2c8f2a8e74b7c8fc312ea1c4be95f230d29521023b0ebceed28186aa0b78fa0467d39bd1d83015903c77e2827b296011f0973d1d1e1faf91cec10e0377022f5dc0512a96e8ca425c4eae503922b2579f19548df24af0fde1d5e14a3fa9e84b77a7c2b47bc542b2f48109dce06914dea8657c097b850996c4b2212cf8ca5f6aadcf8988665e0e575b02cf05ed0baa5a5e4dcdd149a3ad773d76d1c84506dcaaaf9af83b669fdd2ae8d2b5c19bd165a5e40ff5e4d1c6017263e2f2911e0d158fa7c568fb87b75a6d12058df92796593b9afd73f7c7d1c884674030babe7ac2ec96ffe47689b7681395e656ee127f703db3724a5ee750ac00e0fd30599938b6952247cfa543229762f1615207aa002d172c1aee23cdd5a3027bee7201be3e8987763c7c24f7b7052cb4542b374cd82d483514171d3b5c7290477842d8cd7df72032503a6bae2bce6681b9102ca2f3781a4a2ce8bba71f5df76db4101";
    const GAMMA_BYTES: vector<u8> = x"edf692d95cbdde46ddda5ef7d422436779445c5e66006a42761e1f12efde0018c212f3aeb785e49712e7a9353349aaf1255dfb31b7bf60723a480d9293938e99";
    const DELTA_BYTES: vector<u8> = x"38aab17fe92c61cd0066c8ac82f321b264e999b2571e572de2fc3f3bef58f7261b9ef093d45cd22f0ca6cfb734f4bff9faf14320347d2e403d5849ef6582ae2b";

    public fun verify(input_bytes: vector<u8>, proof_bytes: vector<u8>): bool {
        verify_groth16_proof(input_bytes, proof_bytes)
    }

    fun verify_groth16_proof(inputs_bytes: vector<u8>, proof_bytes: vector<u8>): bool {
        let curve = bn254();
        let pvk = groth16::pvk_from_bytes(VK_BYTES, ALPHA_BYTES, GAMMA_BYTES, DELTA_BYTES);
        let inputs = groth16::public_proof_inputs_from_bytes(inputs_bytes);
        let proof = groth16::proof_points_from_bytes(proof_bytes);
        groth16::verify_groth16_proof(&curve, &pvk, &inputs, &proof)
    }
}
