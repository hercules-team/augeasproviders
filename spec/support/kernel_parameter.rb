# frozen_string_literal: true

shared_examples_for 'kernel_parameter resource' do
  it { is_expected.to have_kernel_parameter_resource_count(1) }

  it do
    is_expected.to contain_kernel_parameter('elevator').only_with('name' => 'elevator',
                                                                  'ensure'    => 'present',
                                                                  'value'     => 'deadline')
  end
end

shared_context 'kernel_parameter' do
  it { is_expected.to have_kernel_parameter_resource_count(0) }

  let :example_params do
    { 'elevator' => { 'value' => 'deadline' } }
  end

  context 'when kernel_parameter_hash is a Hash' do
    let(:params) { { kernel_parameter_hash: example_params } }
    let(:facts) { {} }

    include_examples 'kernel_parameter resource'
  end

  context 'when ::augeasproviders_kernel_parameter_hash is a Hash' do
    let(:params) { {} }
    let(:facts) { { augeasproviders_kernel_parameter_hash: example_params } }

    include_examples 'kernel_parameter resource'
  end
end
